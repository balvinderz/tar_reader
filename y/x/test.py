import tarfile
f = tarfile.open("test.tar.gz","r")
for member in f.getmembers():
    print(member.name)
