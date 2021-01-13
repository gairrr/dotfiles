for f in .??*
do
	[[ "$f" == ".git" ]] && continue
	[[ "$f" == ".DS_Store" ]] && continue

	ln -s ~/GoogleDrive/dotfiles/"$f" ~/
done
