# `deeplearning-prepare-data` - Prepare input data for deep learning with PyTorch

This pipeline prepares images generated by Clinica to be used with the PyTorch deep learning library [[Paszke et al., 2019]](https://papers.nips.cc/paper/9015-pytorch-an-imperative-style-high-performance-deep-learning-library). Three types of tensors are proposed: 3D images, 3D patches or 2D slices.

Currently, only outputs from the [`t1-linear` pipeline](../T1_Linear) can be processed. This pipeline was designed as a prerequisite for the deep learning classification algorithms presented in [[Wen et al., 2020](https://doi.org/10.1016/j.media.2020.101694)] and showcased in the [AD-DL framework](https://github.com/aramis-lab/AD-DL).

## Prerequisites
<!-- Depending on the type of feature or the type of modality you want to use, you will need to execute either the [`t1-linear` pipeline](../T1_Linear) , the [`t1-volume` pipeline](../T1_Volume) and/or the [`pet-volume` pipeline](../PET_Volume)  prior to running this pipeline. -->

You need to have performed the [`t1-linear` pipeline](../T1_Linear) on your T1-weighted MRI.

## Dependencies
If you installed the core of Clinica, this pipeline needs no further dependencies.

## Running the pipeline
The pipeline can be run with the following command line:
```Text
clinica run deeplearning-prepare-data <caps_directory> <tensor_format>
```
where:

- `caps_directory` is the folder containing the results of the [`t1-linear` pipeline](../T1_Linear) and the output of the present command, both in a [CAPS hierarchy](../../CAPS/Introduction).
- `tensor_format` is the format of the extracted tensors. You can choose between `image` to convert to PyTorch tensor the whole 3D image, `patch` to extract 3D patches and `slice` to extract 2D slices from the image.

By default the features are extracted from the cropped image (see the documentation of the [`t1-linear` pipeline](../T1_Linear)). You can deactivate this behaviour with the `--use_uncropped_image` flag.

Pipeline options if you use `patch` extraction:

- `--patch_size`: patch size. Default value: `50`.
- `--stride_size`:  stride size. Default value: `50`.

Pipeline options if you use `slice` extraction:

- `--slice_direction`: slice direction. You can choose between `0` (sagittal plane), `1`(coronal plane) or `2` (axial plane). Default value: `0`.
- `--slice_mode`: slice mode. You can choose between `rgb` (will save the slice in three identical channels) or `single` (will save the slice in a single channel). Default value: `rgb`.

!!! note "Regarding the default values"
	When using patch or slice extraction, default values were set according to [[Wen et al., 2020](https://doi.org/10.1016/j.media.2020.101694)].

!!! note
	The arguments common to all Clinica pipelines are described in [Interacting with clinica](../InteractingWithClinica).

!!! tip
	Do not hesitate to type `clinica run deeplearning-prepare-data --help` to see the full list of parameters.


## Outputs
In the following subsections, files with the `.pt` extension denote tensors in PyTorch format.

The full list of output files can be found in the [ClinicA Processed Structure (CAPS) Specification](../../CAPS/Specifications/#deeplearning-prepare-data-prepare-input-data-for-deep-learning-with-pytorch).

### Image-based outputs
Results are stored in the following folder of the [CAPS hierarchy](docs/CAPS): `subjects/<subject_id>/<session_id>/deeplearning_prepare_data/image_based/t1_linear`.

The main output files are:

- `<source_file>_space-MNI152NLin2009cSym[_desc-Crop]_res-1x1x1_T1w.pt`: tensor version of the 3D T1w image registered to the [`MNI152NLin2009cSym` template](https://bids-specification.readthedocs.io/en/stable/99-appendices/08-coordinate-systems.html) and optionally cropped.

### Patch-based outputs

Results are stored in the following folder of the [CAPS hierarchy](docs/CAPS): `subjects/<subject_id>/<session_id>/deeplearning_prepare_data/patch_based/t1_linear`.

The main output files are:

- `<source_file>_space-MNI152NLin2009cSym[_desc-Crop]_res-1x1x1_patchsize-<N>_stride-<M>_patch-<i>_T1w.pt`: tensor version of the `<i>`-th 3D isotropic patch of size `<N>` with a stride of `<M>`. Each patch is extracted from the T1w image registered to the [`MNI152NLin2009cSym` template](https://bids-specification.readthedocs.io/en/stable/99-appendices/08-coordinate-systems.html) and optionally cropped.

### Slice-based outputs

Results are stored in the following folder of the [CAPS hierarchy](docs/CAPS): `subjects/<subject_id>/<session_id>/deeplearning_prepare_data/slice_based/t1_linear`.

The main output files are:

- `<source_file>_space-MNI152NLin2009cSym[_desc-Crop]_res-1x1x1_axis-{sag|cor|axi}_channel-{single|rgb}_T1w.pt`: tensor version of the `<i>`-th 2D slice in `sag`ittal, `cor`onal or `axi`al plane using three identical channels (`rgb`) or one channel (`single`). Each slice is extracted from the T1w image registered to the [`MNI152NLin2009cSym` template](https://bids-specification.readthedocs.io/en/stable/99-appendices/08-coordinate-systems.html) and optionally cropped.


## Going further

- You can now perform classification based on deep learning using the [AD-DL framework](https://github.com/aramis-lab/AD-DL) presented in [[Wen et al., 2020](https://doi.org/10.1016/j.media.2020.101694)].

## Describing this pipeline in your paper

!!! cite "Example of paragraph"
    These results have been obtained using the `deeplearning-prepare-data` pipeline of Clinica [[Routier et al](https://hal.inria.fr/hal-02308126/); [Wen et al., 2020](https://doi.org/10.1016/j.media.2020.101694)]. More precisely,

    - 3D images

    - 3D patches with patch size of `<patch_size>` and stride size of `<stride_size>`

    - 2D slices in {sagittal | coronal | axial} plane and saved in {three identical channels | a single channel}

    were extracted and converted to PyTorch tensors [[Paszke et al., 2019](https://papers.nips.cc/paper/9015-pytorch-an-imperative-style-high-performance-deep-learning-library)].


!!! tip
    Easily access the papers cited on this page on [Zotero](https://www.zotero.org/groups/2240070/clinica_aramislab/collections/8B2R2826).