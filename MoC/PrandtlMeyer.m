%%%%%%%%%%%%%%
% Title  : Using Method of Characteristics for SERN Design
% Author : Neelay Doshi
%%%%%%%%%%%%%%

function nu = PrandtlMeyer(M, gamma)
term_1= (gamma+1)/(gamma-1);
term_2= M^2 - 1;

nu= sqrt(term_1)*atand( sqrt(term_2/term_1) ) - atand( sqrt(term_2) );

