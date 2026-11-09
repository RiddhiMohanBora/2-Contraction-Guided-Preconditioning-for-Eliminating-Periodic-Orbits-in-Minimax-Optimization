function F = poly_gda_field(z,a)
%POLY_GDA_FIELD GDA vector field for the polynomial minimax example.
%   z = [x;y], a > 0, F = [-phi_x; phi_y].

x = z(1);
y = z(2);

F = [ -a*x - y + x^3 - x^5; ...
       x - a*y + y^3 - y^5 ];
end
