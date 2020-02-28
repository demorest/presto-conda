#! /bin/bash

# This build script only works with presto 3.0 and later

export PRESTO=$PREFIX
export LD_LIBRARY_PATH=$PRESTO/lib
export PGPLOT_DIR=$PREFIX/include/pgplot

mkdir -p $PREFIX/bin
mkdir -p $PREFIX/lib
mkdir -p $PREFIX/include
cp -a bin/* $PREFIX/bin
cp -a lib/* $PREFIX/lib
cp -a include/* $PREFIX/include

make -C src makewisdom

make -C src

pip install --no-deps .

rm -r $PREFIX/include

# This foo will make conda automatically define a PRESTO env variable
# when the environment is activated.
etcdir=$PREFIX/etc/conda
mkdir -p $etcdir/activate.d
echo "setenv PRESTO $PREFIX" > $etcdir/activate.d/presto-env.csh
echo "export PRESTO=$PREFIX" > $etcdir/activate.d/presto-env.sh
mkdir -p $etcdir/deactivate.d
echo "unsetenv PRESTO" > $etcdir/deactivate.d/presto-env.csh
echo "unset PRESTO" > $etcdir/deactivate.d/presto-env.sh
