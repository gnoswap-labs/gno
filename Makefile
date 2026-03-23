SHELL := /bin/bash

.PHONY: help init gas-report stress-report metric metric-force stress stress-force compare-metric compare-metric-force compare-stress compare-stress-force summary summary-force clean-worktrees

# Default target
help:
	@echo "Usage (Metric Reports):"
	@echo "  make metric <commits>              # Generate metric reports (skip existing)"
	@echo "  make metric-force <commits>        # Force regenerate all metric reports"
	@echo "  make stress <commits>              # Generate stress reports (skip existing)"
	@echo "  make stress-force <commits>        # Force regenerate all stress reports"
	@echo ""
	@echo "Usage (Compare):"
	@echo "  make compare-metric <commits>             # Compare metric reports (skip existing)"
	@echo "  make compare-metric-force <commits>       # Force regenerate metric comparisons"
	@echo "  make compare-stress <commits>             # Compare stress reports (skip existing)"
	@echo "  make compare-stress-force <commits>       # Force regenerate stress comparisons"
	@echo ""
	@echo "Usage (Summary):"
	@echo "  make summary                       # Generate summary (skip existing)"
	@echo "  make summary-force                 # Force regenerate all reports and summary"
	@echo ""
	@echo "Usage (Setup):"
	@echo "  make init                          # Initialize project"
	@echo "  make clean-worktrees               # Remove cached benchmark worktrees"

init:
	git submodule update --init --recursive
	cd gno && make install

# --- Simplified Commands ---

# Helper to extract commit arguments (everything after the target name)
ARGS = $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))

# Metric Report Generation Only (No Compare)
metric:
	@./scripts/compare_multiple.sh --skip-exists --report-only $(ARGS)

metric-force:
	@./scripts/compare_multiple.sh --report-only $(ARGS)

stress:
	@./scripts/compare_multiple.sh --stress --skip-exists --report-only $(ARGS)

stress-force:
	@./scripts/compare_multiple.sh --stress --report-only $(ARGS)

# Compare (Generate if missing + Compare)
compare-metric:
	@./scripts/compare_multiple.sh --skip-exists $(ARGS)

compare-stress:
	@./scripts/compare_multiple.sh --stress --skip-exists $(ARGS)

# Compare (Force Regenerate + Compare)
compare-metric-force:
	@./scripts/compare_multiple.sh $(ARGS)

compare-stress-force:
	@./scripts/compare_multiple.sh --stress $(ARGS)

# --- Internal / Legacy Commands ---

# Usage: make gas-report [commit]
gas-report:
	@set -eu; \
	REF="$(or $(word 2,$(MAKECMDGOALS)),main)"; \
	eval "$$(./scripts/prepare_benchmark_workspace.sh "$$REF")"; \
	cleanup() { \
		git -C "$(CURDIR)/gno" worktree remove --force "$$GNO_WORKTREE" >/dev/null 2>&1 || true; \
		git -C "$(CURDIR)/gno" worktree prune >/dev/null 2>&1 || true; \
		rm -rf "$$RUN_ROOT"; \
	}; \
	trap cleanup EXIT; \
	(cd "$$GNOSWAP_WORKTREE" && python3 setup.py --exclude-tests -w "$$RUN_ROOT"); \
	rm -rf "$$GNO_WORKTREE/examples/gno.land/r/gnoswap/scenario/metric"; \
	cp -r tests/metric "$$GNO_WORKTREE/examples/gno.land/r/gnoswap/scenario/metric"; \
	mkdir -p reports/metric/commits; \
	set +e; \
	(cd "$$GNO_WORKTREE/examples/gno.land/r/gnoswap/scenario/metric" && gno test . -v -run .) 2>&1 | ./scripts/parse_metrics.sh > "reports/metric/commits/$$SHORT_COMMIT.md"; \
	test_exit=$${PIPESTATUS[0]}; \
	set -e; \
	if [ "$$test_exit" -ne 0 ] && [ ! -s "reports/metric/commits/$$SHORT_COMMIT.md" ]; then \
		echo "Metric run failed before report generation" >&2; \
		exit "$$test_exit"; \
	fi; \
	echo "Report saved to reports/metric/commits/$$SHORT_COMMIT.md"

# Usage: make stress-report [commit]
stress-report:
	@set -eu; \
	REF="$(or $(word 2,$(MAKECMDGOALS)),main)"; \
	eval "$$(./scripts/prepare_benchmark_workspace.sh "$$REF")"; \
	cleanup() { \
		git -C "$(CURDIR)/gno" worktree remove --force "$$GNO_WORKTREE" >/dev/null 2>&1 || true; \
		git -C "$(CURDIR)/gno" worktree prune >/dev/null 2>&1 || true; \
		rm -rf "$$RUN_ROOT"; \
	}; \
	trap cleanup EXIT; \
	(cd "$$GNOSWAP_WORKTREE" && python3 setup.py --exclude-tests -w "$$RUN_ROOT"); \
	rm -rf "$$GNO_WORKTREE/examples/gno.land/r/gnoswap/scenario/metric"; \
	cp -r tests/metric "$$GNO_WORKTREE/examples/gno.land/r/gnoswap/scenario/metric"; \
	rm -rf "$$GNO_WORKTREE/examples/gno.land/r/gnoswap/scenario/stress"; \
	cp -r tests/stress "$$GNO_WORKTREE/examples/gno.land/r/gnoswap/scenario/stress"; \
	mkdir -p reports/stress/commits; \
	set +e; \
	(cd "$$GNO_WORKTREE/examples/gno.land/r/gnoswap/scenario/stress" && gno test . -v -run .) 2>&1 | ./scripts/parse_metrics.sh > "reports/stress/commits/$$SHORT_COMMIT.md"; \
	test_exit=$${PIPESTATUS[0]}; \
	set -e; \
	if [ "$$test_exit" -ne 0 ] && [ ! -s "reports/stress/commits/$$SHORT_COMMIT.md" ]; then \
		echo "Stress run failed before report generation" >&2; \
		exit "$$test_exit"; \
	fi; \
	echo "Report saved to reports/stress/commits/$$SHORT_COMMIT.md"

# Generate summary report from commit-history.txt
summary:
	@./scripts/generate_summary_report.sh

summary-force:
	@./scripts/generate_summary_report.sh --force

clean-worktrees:
	@set -eu; \
	if [ -d .worktrees/runs ]; then \
		for dir in .worktrees/runs/*; do \
			if [ -d "$$dir/gno" ]; then \
				git -C gno worktree remove --force "$$(python3 -c 'import os,sys; print(os.path.abspath(sys.argv[1]))' "$$dir/gno")" >/dev/null 2>&1 || true; \
			fi; \
		done; \
	fi; \
	if [ -d .worktrees/gnoswap ]; then \
		for dir in .worktrees/gnoswap/*; do \
			if [ -d "$$dir" ]; then \
				git -C gnoswap worktree remove --force "$$(python3 -c 'import os,sys; print(os.path.abspath(sys.argv[1]))' "$$dir")" >/dev/null 2>&1 || true; \
			fi; \
		done; \
	fi; \
	rm -rf .worktrees; \
	git -C gnoswap worktree prune >/dev/null 2>&1 || true; \
	git -C gno worktree prune >/dev/null 2>&1 || true; \
	echo "Removed benchmark worktrees"

# Prevent "No rule to make target" errors for commit hash arguments
%:
	@:
