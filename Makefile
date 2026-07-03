# Top-level orchestration across the formal (Agda/Python) and runtime (Elixir)
# legs. Agda must run from formal/ (modules are RuntimeContract.*, not
# formal.RuntimeContract.*). The contract-check / contract-fresh gates use
# `git status --porcelain` so untracked/orphan files are caught too; they are
# meaningful once the generated/vendored artifacts are committed.

.PHONY: test contract-regen contract-check contract-export contract-fresh formal-test runtime-test

SER  := formal/RuntimeContract/Serialization
GEN  := formal/RuntimeContract/Generated
PRIV := runtime/apps/hoapa_contract/priv/runtime_contract

test: contract-check contract-fresh formal-test runtime-test
	@echo "all checks passed"

# Regenerate the data-only Agda raw terms from JSON fixtures.
contract-regen:
	@cd $(SER) && python3 generate_raw_agda.py

# Fail if regeneration changes the generated terms (drift) or leaves orphans.
contract-check: contract-regen
	@status="$$(git status --porcelain -- $(GEN))"; \
	if [ -n "$$status" ]; then \
	  echo "contract-check FAILED: generated Agda not in sync with fixtures:"; \
	  echo "$$status"; exit 1; \
	fi; \
	echo "contract-check OK: generated Agda in sync"

# Export the formal serialization contract into the runtime vendored artifact.
contract-export:
	@cd $(SER) && python3 export_contract.py

# Fail if the vendored runtime artifact is stale vs the formal source.
contract-fresh: contract-export
	@status="$$(git status --porcelain -- $(PRIV))"; \
	if [ -n "$$status" ]; then \
	  echo "contract-fresh FAILED: runtime vendored contract is stale:"; \
	  echo "$$status"; exit 1; \
	fi; \
	echo "contract-fresh OK: runtime contract up to date"

# Formal conformance suite + realization witness (from the Agda include root).
formal-test:
	@cd formal && agda RuntimeContract/Tests/All.agda
	@cd formal && agda RuntimeContract/Realization/TinyTrace.agda
	@cd formal && agda RuntimeContract/Realization/BackwardRank.agda
	@cd formal && agda RuntimeContract/Realization/CausalFromParents.agda
	@echo "formal-test OK"

# Runtime codec + conformance tests (self-contained; reads only priv/).
runtime-test:
	@cd runtime && mix test
