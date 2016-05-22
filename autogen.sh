for f in lib/*/*
do
    echo "Machine.add(\"$f\");"
done
echo "for(0=>int i;i<me.args();i++)"
echo "  Machine.add(me.arg(i));"
