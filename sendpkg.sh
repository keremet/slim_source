#!/usr/bin/ksh93
rm -r incoming
mkdir incoming
for package in $(pkgrecv -s /home/keremet/slim_source/packages/i386/nightly-nd/repo.redist --newest); do
	pkgrecv -s /home/keremet/slim_source/packages/i386/nightly-nd/repo.redist -d incoming --raw $package
done

for pdir in incoming/*/* ; do
	pkgmogrify $pdir/manifest change-pub.mog > $pdir/manifest.newpub
	pkgsend -s /mnt/hipster_repo161031/ publish -d $pdir $pdir/manifest.newpub
done
