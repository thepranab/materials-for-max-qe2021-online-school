# PURPOSE OF THE EXERCISE:
## How to calculate and plot the electron charge density
------------------------------------------------------

**chdens** = **CH**arge **DENS**ity


* **Example 1:**  `1-chdens.pwtk`

  This example shows how to calculated valence charge density. Please
  **edit the `chdens.pwtk` file** and **set the requested variables**
  before running it. To run the example, execute:

        pwtk 1-chdens.pwtk

   After calculations are done, charge density is shown with
   `xcrysden`.  Notice that electron charge is located mainly in
   interstitial regions (due to the use of pseudo-potential, there is
   no charge in the vicinity of nuclei)


* **Example 2:**  `2-chdens-paw.pwtk`

  This examples shows how to calculate all electron *VALENCE* and *TOTAL*
  charge density by using the PAW potential. Notice now the electron
  charge around nuclei. To run the example, execute:

        pwtk 2-chdens-paw.pwtk
     
  Calculated all electron *VALENCE* and *TOTAL* charge density can be
  visuazlied as:
  
        xcrysden --xsf all-electron-VALENCE-chdens.xsf -s state2.xcrysden

  and
  
        xcrysden --xsf all-electron-total-chdens.xsf  -s state2.xcrysden

  Notice the charge density around the nuclei and how the all electron
  *VALENCE* and *TOTAL* charge density differ to each other.
