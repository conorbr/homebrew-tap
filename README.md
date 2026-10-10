# conorbr/tap

Homebrew formulae.

```bash
brew install conorbr/tap/gogo
```

| Formula | What |
|---|---|
| [gogo](https://github.com/conorbr/gogo) | Open a configured terminal workspace with one command |

## Releasing a new gogo version

1. Tag the release in the gogo repo (`vX.Y.Z`) and push the tag.
2. In `Formula/gogo.rb`, update `url` to the new tag and `sha256` to:
   `curl -fsSL https://github.com/conorbr/gogo/archive/refs/tags/vX.Y.Z.tar.gz | shasum -a 256`
3. Check it, then push:
   `brew audit --strict conorbr/tap/gogo && brew install --build-from-source conorbr/tap/gogo && brew test conorbr/tap/gogo`
