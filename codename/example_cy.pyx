#cython: boundscheck=False, wraparound=False, nonecheck=False, cdivision=True
cimport numpy as np
from cython.parallel import prange
from cpython cimport bool
cimport cython
from libc.math cimport sqrt, M_PI, exp, pow

def kernel_parts_interp(
            int NO1, int NO2,
            double[:,:] Kinterp,
            long[:] b1,
            double[:] fz1,
            long[:] p1s,
            long [:] b2,
            double[:] fz2,
            long[:] p2s,
            double[:] fzGrid,
            double[:,:,:,:] Kgrid):

    cdef int p1, p2, o1, o2
    cdef double dzm2, opz1, opz2
    for o1 in prange(NO1, nogil=True):
        opz1 = fz1[o1]
        p1 = p1s[o1]
        for o2 in range(NO2):
            opz2 = fz2[o2]
            p2 = p2s[o2]
            dzm2 = 1. / (fzGrid[p1+1] - fzGrid[p1]) / (fzGrid[p2+1] - fzGrid[p2])
            Kinterp[o1, o2] = dzm2 * (
                (fzGrid[p1+1] - opz1) * (fzGrid[p2+1] - opz2) * Kgrid[b1[o1], b2[o2], p1, p2]
                + (opz1 - fzGrid[p1]) * (fzGrid[p2+1] - opz2) * Kgrid[b1[o1], b2[o2], p1+1, p2]
                + (fzGrid[p1+1] - opz1) * (opz2 - fzGrid[p2]) * Kgrid[b1[o1], b2[o2], p1, p2+1]
                + (opz1 - fzGrid[p1]) * (opz2 - fzGrid[p2]) * Kgrid[b1[o1], b2[o2], p1+1, p2+1]
                )
