all:
	docker build -t azukiappp/php7 .

no-cache:
	docker build --rm --no-cache -t azukiappp/php7 .
