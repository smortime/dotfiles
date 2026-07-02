function prpi --description "Start Pi PR review for current branch or a Graphite branch/PR"
    if test (count $argv) -gt 0
        if test "$argv[1]" = -h; or test "$argv[1]" = --help
            echo "usage: prpi [graphite-branch-or-pr]"
            echo "       prpi -- <checkout command...>"
            echo
            echo "examples:"
            echo '  prpi                              # review current branch'
            echo '  prpi "smortimer/example-pr"       # runs: gt get "smortimer/example-pr"'
            echo '  prpi -- gt get "smortimer/example-pr"'
            return 0
        end
    end

    set -l target
    set -l checkout_cmd

    if test (count $argv) -eq 0
        set target (git branch --show-current 2>/dev/null)
        if test -z "$target"
            echo "usage: prpi [graphite-branch-or-pr]"
            echo "       prpi -- <checkout command...>"
            return 2
        end

        echo "→ reviewing current branch: $target"
        echo
    else if test "$argv[1]" = --
        set checkout_cmd $argv[2..-1]
        if test (count $checkout_cmd) -eq 0
            echo "usage: prpi -- <checkout command...>"
            return 2
        end
        set target $checkout_cmd[-1]
    else if test (count $argv) -ge 2; and test "$argv[1]" = gt; and test "$argv[2]" = get
        # Backward compatible with the old form:
        #   prpi gt get "smortimer/example-pr"
        set checkout_cmd $argv
        set target $checkout_cmd[-1]
    else
        if test (count $argv) -gt 1
            echo "prpi accepts one Graphite target. For custom checkout commands, use:"
            echo "  prpi -- <checkout command...>"
            return 2
        end

        set target $argv[1]
        set checkout_cmd gt get $target
    end

    if test (count $checkout_cmd) -gt 0
        set -l checkout_program $checkout_cmd[1]
        set -l checkout_args $checkout_cmd[2..-1]

        if not type -q $checkout_program
            echo "Checkout command not found: $checkout_program"
            return 127
        end

        echo "→ running checkout command:"
        echo "  "(string join " " -- $checkout_cmd)
        echo

        $checkout_program $checkout_args
        set -l checkout_status $status

        if test $checkout_status -ne 0
            echo
            echo "Checkout command failed with status $checkout_status"
            return $checkout_status
        end
    end

    set -l branch (git branch --show-current 2>/dev/null)
    if test -z "$branch"
        set branch $target
    end

    set -l session_name (string replace -ra '[^[:alnum:]._-]+' '-' -- $branch)

    pi \
        --name "PR review $session_name" \
        --thinking high \
        "/pr-review $branch"
end
