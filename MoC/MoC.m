%%%%%%%%%%%%%%
% Title  : Using Method of Characteristics for SERN Design
% Author : Neelay Doshi
%%%%%%%%%%%%%%
%%%%%%%%%%%%%%
function out = MoC(M0, Me, n, gamma)

%%%%%%%%%%%%%%
% turning angle for first ramp
nu_0= PrandtlMeyer(M0, gamma); 
nu_e= PrandtlMeyer(Me, gamma);
theta_turn= (nu_e - nu_0)/2;
theta_n= theta_turn/(n-1);

%%%%%%%%%%%%%%
theta_arr   = 0 : theta_n : theta_turn;
nu_arr      = theta_arr + nu_0;
K_arr       = nu_arr + theta_arr;

%%%%%%%%%%%%%%
K_mat= ones(n);
THETA= zeros(n);
for i= 1:n
    K_mat(i, i:end)= -1;
    THETA(i, i:end)= theta_arr(1:end-(i-1) );
end
THETA= THETA + THETA';


%%%%%%%%%%%%%%
K   = K_arr'.*K_mat; % each row of K_mat multiplied with same element of K_arr
NU  = abs(K-THETA);


%%%%%%%%%%%%%%
MACH= zeros(n);
for i= 1:n
    for j= i:n
        MACH(i, j)=  InversePrandtlMeyer(M0, Me, NU(i, j), gamma);                       
    end
end
MACH= MACH + MACH' - eye(n).*MACH;

MU  = asind(1./MACH);
MU  = K_mat'.*MU + 2*eye(n).*MU;

SLOPE= MU + THETA; %in degrees


%%%%%%%%%%%%%%
% Computing Internal Grid Points 
%%%%%%%%%%%%%%
% 
% Equation of two lines:
% y = m1*x1 + c1
% y = m2*x2 + c2
%
% Computing intersection points using matrix multiplication:
% [-m1, 1] [x] = [c1]
% [-m2, 1] [y] = [c2]
%    [A] x [B] = [C]
%          [B] = inv([A]) x [C]
%
% Extracting "x" and "y" value from matrix "B":
% x = B(1)
% y = B(2)
%

m_ALL= tand(SLOPE);
m_start= -abs( m_ALL(:, 1) ) ; 
c_start= ones(n, 1);

m_symmetry= 0;
c_symmetry= 0;

m1= m_start(1);
c1= c_start(1);
m2= m_symmetry;
c2= c_symmetry;

A= [-m1, 1; -m2, 1];
C= [c1; c2];
B= A\C;

X= zeros(n);
X(1, 1)= B(1);
Y= zeros(n);
Y(1, 1)= B(2);

%%%%%%%%%%%%%%
for i= 2:n
    m1= m_start(i);
    c1= c_start(i);
    m2= m_ALL(1, i-1) ;
    c2= Y(1, i-1) - m_ALL(1, i-1)*X(1, i-1);
    
    A= [-m1, 1; -m2, 1];
    C= [c1; c2];

    B= A\C;
    X(1, i)= B(1);
    Y(1, i)= B(2);
end

X= X + X' - eye(n).*X;
Y= Y + Y' - eye(n).*Y;

%%%%%%%%%%%%%%
m_symmetry= 0;
c_symmetry= 0;
for i= 2:n
    for j= i:n
        if i == j % diagonal 
            m1= m_ALL(i, j-1);
            c1= Y(i, j-1) - m1*X(i, j-1);
            m2= m_symmetry;
            c2= c_symmetry;

            A= [-m1, 1; -m2, 1];
            C= [c1; c2];

            B= A\C;
            X(i, j)= B(1);
            Y(i, j)= B(2);
            
        else
            m1= m_ALL(i, j-1);
            c1= Y(i, j-1) - m1*X(i, j-1);
            m2= m_ALL(j, i-1);
            c2= Y(j, i-1) - m2*X(j, i-1);
            
            A= [-m1, 1; -m2, 1];
            C= [c1; c2];

            B= A\C;
            X(i, j)= B(1);
            Y(i, j)= B(2);
            
            X(j, i)= X(i, j);
            Y(j, i)= Y(i, j);
        end

    end
end


%%%%%%%%%%%
% ROOF
m_ROOF= zeros(1, n);
c_ROOF= zeros(1, n);

X_ROOF= zeros(1, n);
Y_ROOF= zeros(1, n);

%%%%%%%%%%%
% First Intersection Point
m_ROOF(1)= tand(theta_turn);
c_ROOF(1)= 1;

m1= m_ROOF(1);
c1= c_ROOF(1);
m2= m_ALL(1, end) ;
c2= Y(1, end) - m2*X(1, end);

A= [-m1, 1; -m2, 1];
C= [c1; c2];

B= A\C;
X_ROOF(1)= B(1);
Y_ROOF(1)= B(2);


%%%%%%%%%%%%%%
for i= 2:n
    m_ROOF(i)= tand( THETA(i-1, end) );
    c_ROOF(i)= Y_ROOF(i-1) - m_ROOF(i)*X_ROOF(i-1);
    
    m1= m_ROOF(i);
    c1= c_ROOF(i);
    m2= m_ALL(i, end) ;
    c2= Y(i, end) - m2*X(i, end);
    
    A= [-m1, 1; -m2, 1];
    C= [c1; c2];

    B= A\C;
    X_ROOF(i)= B(1);
    Y_ROOF(i)= B(2);
end


%%%%%%%%%%%
% output data
X_ROOF = X_ROOF - X_ROOF(1);
Y_ROOF = Y_ROOF - Y_ROOF(1);
M0_arr = ones(1, n)*M0;
Me_arr = ones(1, n)*Me;
out = [X_ROOF; M0_arr; Me_arr; Y_ROOF];

end % for function statement







