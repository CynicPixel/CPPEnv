#!/bin/bash
# CP Lab - Single Entry Point Script (Unix)
# Usage: ./cp.sh {run|save|setup|list|status} [args]

case $1 in
    run)
        ./scripts/unix/run.sh "${@:2}"
        ;;
    save)
        ./scripts/unix/save.sh "${@:2}"
        ;;
    setup)
        ./scripts/unix/setup.sh "${@:2}"
        ;;
    list)
        ./scripts/unix/list.sh "${@:2}"
        ;;
    status)
        ./scripts/unix/status.sh "${@:2}"
        ;;
    help|--help|-h)
        echo "🏆 CP Lab - Competitive Programming Environment"
        echo "═══════════════════════════════════════════════"
        echo ""
        echo "Usage: ./cp.sh <command> [arguments]"
        echo ""
        echo "Commands:"
        echo "  run [solution_name]     - Compile and run code (current or saved)"
        echo "  save <name> [desc]      - Save current solution with name"
        echo "  setup [problem_name]    - Reset workspace for new problem"
        echo "  list [solution_name]    - List all solutions or view specific one"
        echo "  status                  - Show current workspace status"
        echo "  help                    - Show this help message"
        echo ""
        echo "Examples:"
        echo "  ./cp.sh run                           # Run current solution"
        echo "  ./cp.sh run binary_search            # Run saved solution"
        echo "  ./cp.sh save two_sum \"Two sum problem\"  # Save current solution"
        echo "  ./cp.sh setup binary_search          # Start new problem"
        echo "  ./cp.sh list                         # List all solutions"
        echo "  ./cp.sh status                       # Show workspace status"
        ;;
    *)
        echo "❌ Error: Unknown command '$1'"
        echo "💡 Use: ./cp.sh help for usage information"
        echo ""
        echo "Available commands: run, save, setup, list, status, help"
        exit 1
        ;;
esac
