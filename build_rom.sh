# sync rom
#repo init --depth=1 --no-repo-verify -u git://github.com/DerpFest-11/manifest.git -b 11 -g default,-mips,-darwin,-notdefault
#git clone https://github.com/pocox3pro/Local-Manifests.git --depth 1 -b master .repo/local_manifests
#repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

repo init --depth=1 --no-repo-verify -u https://github.com/Spark-Rom/manifest -b pyro -g default,-mips,-darwin,-notdefault
git clone https://github.com/phoenix-1708/local_manifest.git --depth=1 -b spark .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8



# build rom
lunch spark_sweet-userdebug


export ALLOW_MISSING_DEPENDENCIES=true

export SKIP_ABI_CHECKS=true

export SKIP_API_CHECKS=true

export TZ=Asia/Dhaka #put before last build command

mka bacon
lunch spark_sweet-userdebug
export ALLOW_MISSING_DEPENDENCIES=true
export SKIP_ABI_CHECKS=true
export SKIP_API_CHECKS=true
export TZ=Asia/Dhaka #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
