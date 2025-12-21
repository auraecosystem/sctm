git init                # initialize repo
git add my_sctm_code.py # stage file
git commit -m "Add SCTM code"
git branch -M main
git remote add origin https://github.com/username/sctm.git
git push -u origin main

echo "sctm_code_here" > sctm_code.py

cd /usr/src/redhat/SOURCES
wget http://www.acme.com/software/mini_httpd/mini_httpd-1.30.tar.gz
rpm -ta mini_httpd-1.30.tar.gz
rpm -i /usr/src/redhat/RPMS/i386/mini_httpd-1.30-1.i386.rpm
    
