#------------------------------------------------------------------------
#
# REMARK:
#
# To compile installation.xml page to installation.html page,
# xsltproc and tidy are required.
#
#------------------------------------------------------------------------
.SUFFIXES: .html .xml

TIDY = tidy -i -utf8
HTML = installation.html
OTHER = page.xsl style.css images/

ALL_FILES = $(HTML) $(OTHER)  

default: clean $(HTML) 

clean:
	-rm $(HTML)
	-rm tmp.html *.tgz *~ */*~

%.html : %.xml page.xsl
	-xsltproc $< > tmp.html
	-$(TIDY) tmp.html > $@
	-rm tmp.html

tgz:
	-rm tmp.html	
	tar zcvf qe2021-web.tgz $(ALL_FILES)
