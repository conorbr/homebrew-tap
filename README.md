# conorbr/tap

Homebrew formulae.

```bash
brew install conorbr/tap/gogo
```

| Formula | What |
|---|---|
| [gogo](https://github.com/conorbr/gogo) | Open a configured terminal workspace with one command |

## Releasing a new gogo version

The formula installs prebuilt binaries, so users never need Rust.

1. In the gogo repo, bump the version, then tag and push (`git tag -a vX.Y.Z -m "gogo X.Y.Z" && git push origin vX.Y.Z`). The Release workflow builds four binaries and attaches them, with `.sha256` files, to the GitHub Release.
2. Print the new checksums:
   ```bash
   for t in aarch64-apple-darwin x86_64-apple-darwin aarch64-unknown-linux-musl x86_64-unknown-linux-musl; do
     curl -fsSL "https://github.com/conorbr/gogo/releases/download/vX.Y.Z/gogo-vX.Y.Z-$t.tar.gz.sha256"
   done
   ```
3. In `Formula/gogo.rb`, replace the version in all four `url`s and paste the four `sha256`s.
4. Commit, then check from a clean tap before pushing:
   ```bash
   brew untap conorbr/tap && brew tap conorbr/tap ~/Developer/homebrew-tap
   brew audit --strict conorbr/tap/gogo && brew install conorbr/tap/gogo && brew test conorbr/tap/gogo
   ```
   A local tap clones commits, so commit first or you'll test the old formula.
5. Push, then `brew untap conorbr/tap && brew tap conorbr/tap` to go back to the GitHub copy.
