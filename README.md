# homebrew-tap

```sh
brew install cozy-creator/tap/cozy
```

- `Formula/cozy.rb`: the release's prebuilt `cozy` (macOS and Linux, arm64 and x86_64), pushed by
  [cozy-creator's release workflow](https://github.com/cozy-creator/cozy-creator/blob/master/.github/workflows/release.yml)
  after a release passes its gate. `brew upgrade cozy` updates it.
- `homebrew-core/cozy.rb`: the source-built formula for a homebrew-core submission.
- `.github/workflows/test.yml`: installs on GitHub's macOS and Linux runners; builds and audits the core formula.
- `.github/workflows/name-watch.yml`: weekly, opens an issue here if anyone proposes a `cozy` formula or cask.
