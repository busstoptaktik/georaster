init:
# projsync --all
#
projgrids := "c:/Users/$USERNAME/AppData/Local/proj"
nkg_2017 := "eur_nkg_nkgrf17vel.tif"
gda94 := "au_icsm_GDA94_GDA2020_conformal_and_distortion.tif"
at_bev := "at_bev_AT_GIS_GRID.tif"
s34j := "dk_sdfi_s34j_2022.tif"

show:
    echo {{projgrids}}/{{nkg_2017}}

gridshift:
    echo 112.4 -13.35 0 2020 | cct proj=hgridshift grids=au_icsm_GDA94_GDA2020_conformal_and_distortion.tif epoch=4000 --

deformation:
    echo 18 59 30 2100 | cct proj=pipeline step proj=cart step proj=deformation dt=100 grids=eur_nkg_nkgrf17vel.tif --
    echo 18 59 30 2100 | cct proj=pipeline step proj=cart step proj=deformation dt=100 grids=eur_nkg_nkgrf17vel.tif step inv proj=cart --

info_at:
    cargo run --example info {{projgrids}}/{{at_bev}}
info_dnn:
    cargo run --example info  {{projgrids}}/dk_sdfe_dnn.tif
info_gda:
    gdalinfo  {{projgrids}}/{{gda94}}
    cargo run --example info  {{projgrids}}/{{gda94}}
    gdallocationinfo  {{projgrids}}/{{gda94}} 33 44
    cargo run --example pixel  {{projgrids}}/{{gda94}} 33 44
info_nkg:
    gdalinfo  {{projgrids}}/{{nkg_2017}}
    cargo run --example info  {{projgrids}}/{{nkg_2017}}
    gdallocationinfo  {{projgrids}}/{{nkg_2017}} 33 44
    cargo run --example pixel  {{projgrids}}/{{nkg_2017}} 33 44
info_at_bev:
    # gdalinfo  {{projgrids}}/{{at_bev}}
    # cargo run --example info  {{projgrids}}/{{at_bev}}
    gdallocationinfo  {{projgrids}}/{{at_bev}} 33 44
    cargo run --example pixel  {{projgrids}}/{{at_bev}} 33 44
info_s34j:
    gdalinfo  {{projgrids}}/{{s34j}}
    cargo run --example info  {{projgrids}}/{{s34j}}
    gdallocationinfo  {{projgrids}}/{{s34j}} 33 44
    cargo run --example pixel  {{projgrids}}/{{s34j}} 33 44
