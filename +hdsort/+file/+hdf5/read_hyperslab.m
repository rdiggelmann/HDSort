function X = read_hyperslab(fname, h5path, block, offset)
    plist = 'H5P_DEFAULT';
    rmode = 'H5F_ACC_RDONLY';
    fid = H5F.open(fname,rmode,plist); 
    dset_id = H5D.open(fid, h5path);
    X = hdsort.file.hdf5.read_dset(dset_id, block, offset);
    H5D.close(dset_id);
    H5F.close(fid);