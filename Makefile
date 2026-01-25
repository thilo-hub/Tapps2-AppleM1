
all: docker

TAPPS2="https://www.ta.co.at/fileadmin/Downloads/Software/TAPPS2/Linux/64bit/tapps2-1.24-amd64.deb"
WINSOL="https://www.ta.co.at/download/datei/17978?tx_taproducts_downloadservice%5Btoken%5D=873648-dsf&cHash=798c3dce64ad99e7f02e010a7eafeb17"

winsol-amd64.deb:
	wget ${WINSOL} -O winsol-amd64.deb

tapps2-amd64.deb:
	wget ${TAPPS2} -O tapps2-amd64.deb

docker: tapps2-amd64.deb winsol-amd64.deb Dockerfile
	docker build -t thiloj/tapps2 --platform linux/amd64 .
