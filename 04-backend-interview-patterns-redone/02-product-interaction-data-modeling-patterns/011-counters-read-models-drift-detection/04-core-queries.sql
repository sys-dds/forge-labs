SET search_path TO bip_pim_011;
-- Core read shape: Compute source counts from source tables, join read-model rows, emit count rows, drift rows, no-drift rows, and repair candidates based on source minus stored values.
