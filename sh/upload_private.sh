
#准备上传的类库 module
upArray=(
#  # 网络库
#  ":ApiHttpSDK:ApiHttpBase"
)

dir_path="Plugins/upload/file"
rm -r "$dir_path"

for element in "${upArray[@]}"
do
  ./gradlew "$element:findDependencies" < /dev/null
done

type_params="r"

for file in "./$dir_path"/*
do
#  echo $file
  if [ -f "$file" ]; then
    while IFS= read -r line
    do
#     echo $line
      if [ "$1" = $type_params ]; then
          ./gradlew "$line:publishUploadPublicationToMaven2Repository" < /dev/null
      else
          ./gradlew "$line:publishUploadPublicationToMavenRepository" < /dev/null
      fi
    done < "$file"
  fi
done

if [ "$1" = $type_params ]; then
    echo "SDK 发布远程结束"
else
    echo "SDK 发布本地结束"
fi
