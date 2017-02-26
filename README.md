Script name      : `zeropad.sh`

Author           : Maciej Dobrzynski

Date created     : 20170224

Purpose          : Process input filename and pad numbers after a string

Example usage:
  assume we have files: `ch1_t1.tif`, `ch1_t2.tif`, etc.
  and we want to rename files such that the numbers after "_t" are padded with 4 digits:

  ``for ii in ch1_t*; do mv $ii `./zeropad_t.sh -p _t -n 4 $ii`; done``

If the selected pattern appears more than once,
the substitution will occur only for the last instance.

**WARNING**: uses GNU getopt
Standard OSX installation of getopt doesn't support long params
Install through macports
`sudo port install getopt`

Tested on:
OSX 10.11.6 (Darwin Kernel Version 15.6.0)
Ubuntu 16.04.2 LTS
