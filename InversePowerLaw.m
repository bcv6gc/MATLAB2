function active_perm = InversePowerLaw(eff_perm, med_perm, active_volume)
beta = 1/3; % 0.8 raisin pudding model, 0.7 swiss cheese model, 1/3 Looynega formula, 1/2 Birchak
active_perm = ((eff_perm.^beta - (1 - active_volume).*med_perm.^beta)./(active_volume)).^(1/beta);
end