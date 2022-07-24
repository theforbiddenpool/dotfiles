git config --global alias.lg "log --oneline --decorate --all --graph"

git config --global alias.st "status"
git config --global alias.s "status -s"

git config --global alias.co "checkout"
git config --global alias.cob "checkout -b"
git config --global alias.com "! git checkout \$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')"

git config --global alias.br "branch"
git config --global alias.brc "branch --show-current"
git config --global alias.brd "branch -d"

git config --global alias.ci "commit"
git config --global alias.cia "commit -av"
git config --global alias.civ "commit -v"
git config --global alias.cim "commit -m"
git config --global alias.ciam "commit -am"
git config --global alias.amend "commit --amend --no-edit"

git config --global alias.aa "add -A"

git config --global alias.ps "push"
git config --global alias.psu "! git push -u origin \$(git branch --show-current)"

git config --global alias.alias "! git config --get-regexp ^alias\. | sed -e s/^alias\.// -e s/\ /\ =\ /"

git config --global set-head "remote set-head origin"
