for f in lib/*/*
do
    echo "Machine.add(\"$f\");"
done
echo "Machine.add(me.arg(0));"
