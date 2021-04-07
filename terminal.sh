while true
do
  echo "Enter command:"
  read command
  if [ $command="exit" ]; then
    exit 0
  else
     $command
  fi
done
