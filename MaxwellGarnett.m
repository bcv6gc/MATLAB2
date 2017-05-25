function active_perm = MaxwellGarnett(eff_perm, med_perm, active_volume)
media_volume = 1-active_volume;
active_perm = ((2+media_volume)*eff_perm - 2*active_volume*med_perm)...
    .*med_perm./((1+2*media_volume)*med_perm - active_volume*eff_perm);
end