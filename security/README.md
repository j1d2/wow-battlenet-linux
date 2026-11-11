# Security and privacy checks

How this guide stays safe to share. To report a problem, see [`SECURITY.md`](../SECURITY.md).

## Automatic checks (every commit, push and pull request)

`scripts/check.sh` runs these. The git hooks and CI run the same script.

| Check | Script | What it stops |
| --- | --- | --- |
| Privacy | `scripts/privacy_scan.sh` | Home, mount and Wine paths, WoW account folders, email addresses, private IP addresses, plus any name in your local denylist |
| Secrets | `scripts/privacy_scan.sh` | Private keys, AWS keys, GitHub, Slack and API tokens, hard-coded passwords |
| Commit messages | `.githooks/commit-msg` | The same privacy and secret rules, run on the message text |
| Links | `scripts/link_check.sh` | A link between the guide's pages that points to a missing file or heading |
| File hygiene | `scripts/hygiene_check.sh` | Big files (over 500 KB), conflict markers, mixed line endings |

The scans print only the file, line and rule, never the matched text, so CI logs don't leak anything either.

**Your own names:** copy `privacy-denylist.example` to `privacy-denylist.local` (git ignores it) and list your account, character and computer names. The local checks then block them too.

**Git history:** `scripts/privacy_scan.sh --history` reports matches in old commits. It found nothing on 2026-11-11.

## Repository settings

Set on GitHub, not in files, so they are written down here.

- **Ruleset "protect-main"** (no one can bypass it, the owner included): changes land only through a pull request, review threads must be resolved, and `main` can't be force-pushed or deleted.
- **Actions:** only GitHub's own actions may run, pinned to a full commit SHA. Workflows get a read-only token and can't approve pull requests. Outside contributors' workflow runs wait for the maintainer's approval.
- **Secret scanning and push protection** are on. **Private vulnerability reporting** is on.
- **Dependabot** alerts are on, and `dependabot.yml` proposes updates to the pinned actions after a 14-day cooldown.
- Merged branches are deleted automatically.
