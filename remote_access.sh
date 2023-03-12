echo ""
echo "Installing dependencies.. please wait."
echo ""
echo ""
apt update -y
apt install tmate -y
echo ""
echo ""
echo "Please provide this to your support agent:"
echo "To exit, press CTRL+C"
tmate -F | grep 'ssh session:'