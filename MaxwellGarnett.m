function effective_perm = MaxwellGarnett(active_perm, med_perm, active_volume)
effective_perm = med_perm + (3*active_volume.*med_perm.*(active_perm - med_perm))./(active_perm + 2*med_perm - active_volume.*(active_perm - med_perm));
end