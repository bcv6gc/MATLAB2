function active_perm = Bruggeman(eff_perm, med_perm, active_volume)
media_volume = 1-active_volume;
active_perm = ((active_volume-2*media_volume)*med_perm + 2*eff_perm)...
    .*eff_perm./(media_volume*(med_perm-eff_perm)+active_volume*(med_perm+2*eff_perm));
end