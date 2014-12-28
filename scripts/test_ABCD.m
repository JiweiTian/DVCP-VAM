%-----------------------------------------------------------------------------
%This is an example, which shows how to use VAModel in MATLAB
%A linearized state space model is generated by using the first-order Taylor expansion coefficients
%-----------------------------------------------------------------------------
% [dstatedt, states, MVs, measurements] = VAModel (states, MVs, time, is_initial, disturbanceID)
%
% The inputs, on the right hand side, are:
% states        = (246 x 1) vector containing the current states.
% MVs           = (26 x 1) vector containing the current values of the manipulated variables.
% time          = current time in minutes.
% is_initial    = binary flag.
%               1 when extracting steady state data.
%               0 when carrying out dynamic simulation.
% disturbanceID = integer flag.
%               1. a step change in the composition of C2H6 in the fresh C2H4
%               feed stream from 0.001 to 0.003 mole fraction;
%               2. loss of column feed.
% 
% The outputs, on the left hand side, are:
% dstatedt      = (246 x 1) vector containing the current derivatives of the states.
% states        = (246 x 1) vector containing the current states (intended to be used for model
%               initialization).
% MVs           = (26 x 1) vector containing the current values of the manipulated variables (intended to be
%               used for model initialization).
% measurement   = (43 x 1) vector containing all the measurements.
%-----------------------------------------------------------------------------
%Copyright: Rong Chen and Kedar David, June 2002
%-----------------------------------------------------------------------------
clear all
close all
format short g
%-----------------------------------------------------------------------------

%-----------------------------------------------------------------------------
%load operating mode
states=zeros(246,1);
MVs=zeros(26,1);
time=0;
is_initial=1;
disturbance_ID=0;
[dx_ss,x_ss,u_ss,y_ss]=VAModel(states,MVs,time,is_initial,disturbance_ID);
%-----------------------------------------------------------------------------

%-----------------------------------------------------------------------------
%initialization
step_size=1e-6; %since the ss max derivative of x is about 1e-7, the size of disturbance should at least be >1e-6, but at most <1e-4
signal_x=step_size;
signal_u=step_size;
x_number=246;
y_number=43;
u_number=26;
%-----------------------------------------------------------------------------

%-----------------------------------------------------------------------------
%generate state space model
AA=zeros(x_number,x_number);
BB=zeros(x_number,u_number);
CC=zeros(y_number,x_number);
DD=zeros(y_number,u_number);
for i=1:x_number
    x=x_ss;
	x(i)=x_ss(i)*(1+signal_x);
    [dx,x,u,y]=VAModel(x,u_ss,0,0,0);
    AA(:,i)=(dx(1:x_number)-dx_ss(1:x_number))/(signal_x*x_ss(i));
	CC(:,i)=(y-y_ss)/(signal_x*x_ss(i));
	x(i)=x_ss(i)*(1-signal_x);
    [dx,x,u,y]=VAModel(x,u_ss,0,0,0);
    AA(:,i)=(-(dx(1:x_number)-dx_ss(1:x_number))/(signal_x*x_ss(i))+AA(:,i))*.5;
	CC(:,i)=(-(y-y_ss)/(signal_x*x_ss(i))+CC(:,i))*.5;
end
for i=1:u_number
	u=u_ss;
	u(i)=u_ss(i)*(1+signal_u);
	[dx,x,u,y]=VAModel(x_ss,u,0,0,0);
	BB(:,i)=(dx(1:x_number)-dx_ss(1:x_number))/(signal_u*u_ss(i));
	DD(:,i)=(y-y_ss)/(signal_u*u_ss(i));
   	u=u_ss;
	u(i)=u_ss(i)*(1-signal_u);
	[dx,x,u,y]=VAModel(x_ss,u,0,0,0);
	BB(:,i)=(-((dx(1:x_number)-dx_ss(1:x_number))/(signal_u*u_ss(i)))+BB(:,i))*.5;
	DD(:,i)=(-(y-y_ss)/(signal_u*u_ss(i))+DD(:,i))*.5;
end
% at this point A,B,C,D have been calculated in unscaled version
%-----------------------------------------------------------------------------

%-----------------------------------------------------------------------------
%get scaled mdoel
A_original=AA;
B_original=BB;
C_original=CC;
D_original=DD;
%states are scaled by the steady state data
x_scale=x_ss;
A=inv(diag(x_scale))*A_original*diag(x_scale);
%MVs are scaled by the allowable moving range
u_scale=[2.268 7.560 4.536 1433400 50 15000 40 4.536 80 30 50000 4.536 50 30000 7.56 5000 22.68 0.02268 1 7.56 100000 150000 2.4 2.4 4.536 4.536]';
B=inv(diag(x_scale))*B_original*diag(u_scale);
%measurement are scaled differently
y_scale=[10 0.5 min(40,y_ss(3)) min(40,y_ss(4)) min(40,y_ss(5)) y_ss(6) min(40,y_ss(7)) min(40,y_ss(8)) 0.5 min(40,y_ss(10))...
        min(40,y_ss(11)) 10 0.5 min(40,y_ss(14)) min(40,y_ss(15)) y_ss(16) y_ss(17) 0.5 0.5 min(40,y_ss(20))...
        0.5 min(40,y_ss(22)) 0.5 y_ss(24:43)']';
C=inv(diag(y_scale))*C_original*diag(x_scale);
D=inv(diag(y_scale))*D_original*diag(u_scale);
%-----------------------------------------------------------------------------

%-----------------------------------------------------------------------------
%show eigenvalues
sort(real(eig(A)));

%close 7 liquid levels (integrators)
%Sep Lvl
K=-1;
A =A -B (:,8)*K*C (9,:);
B =B *diag([1 1 1 1 1 1 1 K 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]);
%Abs Lvl
K=-1;
A =A -B (:,12)*K*C (13,:);
B =B *diag([1 1 1 1 1 1 1 1 1 1 1 K 1 1 1 1 1 1 1 1 1 1 1 1 1 1]);
%Org Lvl
K=-1;
A =A -B (:,23)*K*C (18,:);
B =B *diag([1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 K 1 1 1]);
%Aqu Lvl
K=-1;
A =A -B (:,24)*K*C (19,:);
B =B *diag([1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 K 1 1]);
%Col Lvl
K=-1;
A =A -B (:,25)*K*C (21,:);
B =B *diag([1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 K 1]);
%Tnk Lvl
K=1;
A =A -B (:,3)*K*C (23,:);
B =B *diag([1 1 K 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]);
%Vap Lvl
K=-0.05;
A =A -B (:,4)*K*C (2,:);    
B =B *diag([1 1 1 K 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]);
%To remove a small negative eigenvalue, we can control either the column 5th tray temp or %VAc in column bottom
%----------------------------------------------------------------
%K=-1;
%A =A -B (:,18)*K*C (33,:);
%B =B *diag([1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 K 1 1 1 1 1 1 1 1]);
%----------------------------------------------------------------
%check eigenvalues
sort(real(eig(A)))
svd(A);
return
