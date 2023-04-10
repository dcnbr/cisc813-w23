function [] = replay(statespace_file, relation_file)

% open state space, relation files
state_space = xlsread(statespace_file);
state_relation = xlsread(relation_file);

num_states = size(state_space, 1);

% compute the principle components of the exploired statespace
[comps, ~, vars] = pca(state_space);

% project the state space into the loweer-dimensional space
% spanned by the 2(3) highest-variance-capturing principle components 
state_proj_2d = state_space * comps(:,1:2);
state_proj_3d = state_space * comps(:,1:3);

% compute the proportion of total variability captured by the projection
varprop_2d = sum(vars(1:2))/sum(vars);
varprop_3d = sum(vars(1:3))/sum(vars);

disp("2d variability captured: "+ string(varprop_2d));
disp("3d variability captured: "+ string(varprop_3d));

% plot the first expolored state in colour1, the last explored state in
% colour2, and linearly interpolate between colours for intermediate states
interp = interp1([0 1], [0 1], 0:(1/(num_states-1)):1);
colour1 = [0, 0, .8];
colour2 = [0, .5, 0];
endsz = 100;

% 2d plot
f1 = figure;
grid on
hold on
for ix=1:num_states
    parent_index = state_relation(ix,2) + 1;
    parent   = state_proj_2d(parent_index,:);
    child    = state_proj_2d(ix,:);
    x = [parent(1) child(1)];
    y = [parent(2) child(2)];
    colour = interp(ix).*colour2 + (1-interp(ix)).*colour1;
    plot(x, y, '-o', 'Color', colour);
end

% plot special markers for initial and goal states
start = state_proj_2d(1,:);
goal = state_proj_2d(num_states,:);
scatter(start(1), start(2), endsz, ...
         "o", 'filled', 'MarkerFaceColor', colour1);
scatter(goal(1), goal(2), endsz, ...
         "diamond", 'filled', 'MarkerFaceColor', colour2);
set(gca, 'Xticklabel',[]);
set(gca, 'Yticklabel',[]);
set(f1, 'Position',  [100, 100, 500, 400]);

% 3d plot
f2 = figure;
hold on
grid on
for ix=1:num_states
    parent_index = state_relation(ix,2) + 1;
    parent   = state_proj_3d(parent_index,:);
    child    = state_proj_3d(ix,:);
    x = [parent(1) child(1)];
    y = [parent(2) child(2)];
    z = [parent(3) child(3)];
    colour = interp(ix).*colour2 + (1-interp(ix)).*colour1;
    plot3(x, y, z, '-o', 'Color', colour);
end
% plot special markers for initial and goal states
start = state_proj_3d(1,:);
goal = state_proj_3d(num_states,:);
scatter3(start(1), start(2), start(3), endsz, ...
         "o", 'filled', 'MarkerFaceColor', colour1);
scatter3(goal(1), goal(2), goal(3), endsz, ...
         "diamond", 'filled', 'MarkerFaceColor', colour2);
set(gca, 'Xticklabel',[]);
set(gca, 'Yticklabel',[]);
set(gca, 'Zticklabel',[]);
axis vis3d;
set(gcf, 'Position',  [100, 100, 500, 400]);

end