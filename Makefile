BASE_REPO=latenssi

FTB_REVELATION_VERSION=2.1.0
FTB_REVELATION_DL_URL=https://media.forgecdn.net/files/2574/714/FTBRevelationServer_2.1.0.zip

ftb-revelation:
	docker build \
		-t ${BASE_REPO}/ftb-revelation:${FTB_REVELATION_VERSION} \
		--build-arg DOWNLOAD_URL=${FTB_REVELATION_DL_URL} \
		./ftb/
	docker push ${BASE_REPO}/ftb-revelation:${FTB_REVELATION_VERSION}