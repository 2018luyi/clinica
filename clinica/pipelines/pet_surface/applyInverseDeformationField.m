function applyInverseDeformationField(target, deformation_field, img, output_folder, output_prefix)
    %% Generated by nipype.interfaces.spm
    if isempty(which('spm'))
        throw(MException('SPMCheck:NotFound', 'SPM not in matlab path'));
    end
    [name, version] = spm('ver');
    fprintf('SPM version: %s Release: %s\n',name, version);
    fprintf('SPM path: %s\n', which('spm'));
    spm('Defaults','fMRI');
    
    if strcmp(name, 'SPM8') || strcmp(name(1:5), 'SPM12')
        spm_jobman('initcfg');
        spm_get_defaults('cmdline', 1);
    end
    
jobs{1}.spm.util.defs.comp{1}.inv.comp{1}.def = {deformation_field};
jobs{1}.spm.util.defs.comp{1}.inv.space = {target};
jobs{1}.spm.util.defs.out{1}.pull.fnames = {img};
jobs{1}.spm.util.defs.out{1}.pull.savedir.saveusr = {output_folder};
jobs{1}.spm.util.defs.out{1}.pull.interp = 4;
jobs{1}.spm.util.defs.out{1}.pull.mask = 1;
jobs{1}.spm.util.defs.out{1}.pull.fwhm = [0 0 0];
jobs{1}.spm.util.defs.out{1}.pull.prefix = output_prefix;
    
            spm_jobman('run', jobs);
end