vuc_gioi(sv_nhan_thuc, dong_vat).
vuc_gioi(sv_nhan_thuc, thuc_vat).
vuc_gioi(sv_nhan_thuc, nam).
vuc_gioi(sv_nhan_thuc, sv_nguyen_sinh).
vuc_gioi(sv_nhan_thuc, khoi_sinh).

gioi_vuc(GIOI, VUC) :- vuc_gioi(VUC, GIOI).

gioi_nganh(dong_vat, khong_xuong_song).
gioi_nganh(dong_vat, co_xuong_song).

gioi_nganh(thuc_vat, tv_co_phoi).
gioi_nganh(thuc_vat, tao_luc).

gioi_nganh(nam, chytridiomycota).
gioi_nganh(nam, blastocladiomycota).
gioi_nganh(nam, neocallimastigomycota).
gioi_nganh(nam, zygomycota).
gioi_nganh(nam, ascomycota).
gioi_nganh(nam, basidiomycota).
gioi_nganh(nam, deuteromycota).

nganh_gioi(NGANH, GIOI) :- gioi_nganh(GIOI, NGANH).

nganh_lop(khong_xuong_song, chan_khop).
nganh_lop(khong_xuong_song, ruot_khoang).
nganh_lop(khong_xuong_song, nguyen_sinh).
nganh_lop(khong_xuong_song, giun).
nganh_lop(khong_xuong_song, than_mem).

nganh_lop(co_xuong_song, ca).
nganh_lop(co_xuong_song, bo_sat).
nganh_lop(co_xuong_song, thu).
nganh_lop(co_xuong_song, chim).
nganh_lop(co_xuong_song, luong_cu).

nganh_lop(tv_co_phoi, reu).
nganh_lop(tv_co_phoi, tv_co_mach).

lop_nganh(LOP, NGANH) :- nganh_lop(NGANH, LOP).

lop_bo(thu, thu_huyet).
lop_bo(thu, thu_tui).
lop_bo(thu, doi).
lop_bo(thu, ca_voi).
lop_bo(thu, an_sau_bo).
lop_bo(thu, gam_nham).
lop_bo(thu, an_thit).
lop_bo(thu, mong_guoc).
lop_bo(thu, linh_truong).

bo_lop(BO, LOP) :- lop_bo(LOP, BO).

bo_cung_lop(X, BO) :- lop_bo(LOP, X), lop_bo(LOP, BO), dif(X, BO).
lop_cung_nganh(X, LOP) :- nganh_lop(NGANH, X), nganh_lop(NGANH, LOP), dif(X, LOP).
nganh_cung_gioi(X, NGANH) :- gioi_nganh(GIOI, X), gioi_nganh(GIOI, NGANH), dif(X, NGANH).
gioi_cung_vuc(X, GIOI) :- vuc_gioi(VUC, X), vuc_gioi(VUC, GIOI), dif(X, GIOI).

vuc_nganh(X, NGANH) :- vuc_gioi(X, GIOI), gioi_nganh(GIOI, NGANH).
nganh_vuc(X, VUC) :- vuc_nganh(VUC, X).
nganh_cung_vuc(X, NGANH) :- vuc_nganh(VUC, X), vuc_nganh(VUC, NGANH), dif(X, NGANH).

vuc_lop(X, LOP) :- vuc_nganh(X, NGANH), nganh_lop(NGANH, LOP).
lop_vuc(X, VUC) :- vuc_lop(VUC, X).
lop_cung_vuc(X, LOP) :- vuc_lop(VUC, X), vuc_lop(VUC, LOP), dif(X, LOP).

vuc_bo(X, BO) :- vuc_lop(X, LOP), lop_bo(LOP, BO).
bo_vuc(X, VUC) :- vuc_bo(VUC, X).
bo_cung_vuc(X, BO) :- vuc_bo(VUC, X), vuc_bo(VUC, BO), dif(X, BO).

gioi_lop(X, LOP) :- gioi_nganh(X, NGANH), nganh_lop(NGANH, LOP).
lop_gioi(X, GIOI) :- gioi_lop(GIOI, X).
lop_cung_gioi(X, LOP) :- gioi_lop(GIOI, X), gioi_lop(GIOI, LOP), dif(X, LOP).

gioi_bo(X, BO) :- gioi_lop(X, LOP), lop_bo(LOP, BO).
bo_gioi(X, GIOI) :- gioi_bo(GIOI, X).
bo_cung_gioi(X, BO) :- gioi_bo(GIOI, X), gioi_bo(GIOI, BO), dif(X, BO).

nganh_bo(X, BO) :- nganh_lop(X, LOP), lop_bo(LOP, BO).
bo_nganh(X, NGANH) :- nganh_bo(NGANH, X).
bo_cung_nganh(X, BO) :- nganh_bo(NGANH, X), nganh_bo(NGANH, BO), dif(X, BO).
