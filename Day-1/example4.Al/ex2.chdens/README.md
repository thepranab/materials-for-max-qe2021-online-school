# PURPOSE OF THE EXERCISE:
## How to calculate and plot the electron charge density
------------------------------------------------------

chdens = CHarge DENSity


* **Example 1:**  `1-chdens.pwtk`

  This example shows how to calculated valence charge density. Please
  **edit the file** and **set the requested variables** before running it. To
  run the example, execute:

       pwtk 1-chdens.pwtk

   Notice that electron charge is located mainly in interstitial
   regions (due to the use of pseudo-potential, there is no charge in
   the vicinity of nuclei)


* **Example 2:**  `2-chdens-paw.pwtk`

  This examples shows how to calculate all electron VALENCE and total
  charge density by using the PAW potential. Notice now the electron
  charge around nuclei. To run the example, execute:

       pwtk 2-chdens-paw.pwtk
