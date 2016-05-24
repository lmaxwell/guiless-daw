rm -f run.ck
for f in lib/*/*
do
    echo "Machine.add(\"$f\");" >>run.ck
done
echo "for(0=>int i;i<me.args();i++)">>run.ck
echo "  Machine.add(me.arg(i));">>run.ck
