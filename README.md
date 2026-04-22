# openai-codex

Temporary Arch package override for `openai-codex` `0.122.0` with the merged `apply_patch` hook backport needed to use `context-mode` effectively before upstream `0.123`.

It publishes into the shared local pacman repo at `~/opt/pkgbuilds/`, exposed as repo `[personal]`.

## Manual Build

```bash
./scripts/build-package.sh
./scripts/publish-local.sh
```

## Notes

- This repo intentionally stays on the Arch `0.122.0` source line and bumps only `pkgrel` to `2`.
- The only backport is upstream commit `09ebc34f17b84c4ec7550960b2f9c090f5dde5b7`, which teaches hooks to see `apply_patch`.
- The goal is for official `openai-codex 0.123.0-1` to supersede this automatically.
- Once upstream `0.123` is installed and verified, remove the local package artifact from `~/opt/pkgbuilds/` and refresh `personal.db`.
- This repo is part of my broader private `pkgbuild` setup documented in the `personal-pkgbuilds` base repo.
