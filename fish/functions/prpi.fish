function prpi --description "Checkout a Graphite branch/PR, then start Pi review"
    if test (count $argv) -eq 0
        echo "usage: prpi <checkout command...>"
        echo 'example: prpi gt get "smortimer/example-pr"'
        return 2
    end

    # Allow optional delimiter:
    #   prpi -- gt get "smortimer/example-pr"
    set -l checkout_cmd $argv
    if test "$checkout_cmd[1]" = "--"
        set -e checkout_cmd[1]
    end

    if test (count $checkout_cmd) -eq 0
        echo "usage: prpi <checkout command...>"
        return 2
    end

    set -l target $checkout_cmd[-1]

    echo "→ running checkout command:"
    echo "  $checkout_cmd"
    echo

    set -l checkout_program $checkout_cmd[1]
    set -l checkout_args $checkout_cmd[2..-1]

    $checkout_program $checkout_args
    set -l checkout_status $status

    if test $checkout_status -ne 0
        echo
        echo "Checkout command failed with status $checkout_status"
        return $checkout_status
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
