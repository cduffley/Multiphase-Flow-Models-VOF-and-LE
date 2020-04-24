clear all;
clc;

Nx = 33;
Ny = 33;
%One particle roughly in middle
%mode = 1;
%Uniform Distribution of particles
%mode = 2;
%Random Distribution of particles
%mode = 3;
mode = menu('Choose run mode','test','uniform','random');

matrix = Initialize_particles(Nx,Ny,mode);

figure('Name','Particle Position','NumberTitle','off')
%Display particle matrix
%White squares represent particles
imshow(matrix, 'InitialMagnification', 1500)