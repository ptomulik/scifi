qrcirc
------

This example demonstrates some problems with integration of Index-3 DAEs using
QR decomposition and standard explicit ODE solvers. We consider simple material
point whose motion is restricted to a unit circle q_2^2 + q_2^2 = 1. The point
gets non-zero initial velocity and moves without friction, without gravity and
without external excitations (so it should preserve kinetic energy).


Please compile the ``readme.tex`` file to read more about the sole problem
being demonstrated here

.. code:: shell

    ./compile

Running examples
````````````````

In Matlab or Octave

.. code:: matlab

    qrcirc_test1
    qrcirc_test2
    qrcirc_test3
    qrcirc_test4
