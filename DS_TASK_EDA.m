%% 1.Load the Data

data=readtable("train.csv")

%% 2.Data Cleaning

summary(data)
missingsummary=sum(ismissing(data))

% fill missing values
data.Age=fillmissing(data.Age,"constant",mean(data.Age,"omitnan"))
data.Ticket=fillmissing(data.Ticket,"constant",mean(data.Ticket,"omitnan"))

% Drop rows with missing values
data=data(~ismissing(data.Cabin),:)
data=data(~ismissing(data.Fare),:)
%% 3.Exploratory Data Analysis(EDA)
% summary

summary(data(:,{'Age','Fare'}))
% 3.1 Survival rate by gender

figure
g=gramm("x",data.Sex,"color",data.Survived)
g.stat_bin("geom","bar","dodge",1)
g.set_names("x","sex","y","count","color","survived")
g.draw()
% 3.2 Age distibution by survival

figure
g=gramm("x",data.Age,"color",data.Survived)
g.stat_bin("nbins",20,"normalization","count")
g.set_names("x","Age","y","count","color","survived")
g.draw()
% 3.3 Fare Distribution by class

figure;
g=gramm("x",data.Pclass,"y",data.Fare,"color",data.Pclass)
g.stat_boxplot()
g.set_names("x","Pclass","y","Fare")
g.draw()
% 3.4 Survival Rate by Class

figure
g=gramm("x",data.Pclass,"color",data.Survived)
g.stat_bin("geom","bar","dodge",1)
g.set_names("x","Pclass","y","count","color","survived")
g.draw()
% 3.5 Scatter plot : Age vs Fare

figure
gscatter(data.Age,data.Fare,data.Survived,"br","ox")
xlabel("Age")
ylabel("Fare")
title("Age vs Fare by Survival")
legend("Did not survive","Survived")
% Correlation Matrix

% Compute correlation matrix for numerical variable
num_var = data{:, {'Age', 'SibSp', 'Parch', 'Fare'}}
correlationMatrix = corr(num_var, 'Rows', 'complete')
disp('Correlation Matrix:')
disp(correlationMatrix)

% Display heatmap of the correlation matrix
figure;
heatmap(correlationMatrix, 'XData', {'Age', 'SibSp', 'Parch', 'Fare'}, 'YData', {'Age', 'SibSp', 'Parch', 'Fare'})
title('Correlation Matrix Heatmap')
%% 4.Pattern Identification
% 
%% 
% * Survival rate is higher for females compared to males
% * Passengers in hiher classes(1st class) have a higher survival rate
% * There is a positive correlation between fare and class
% * Younger passengers have a slightly higher chance of survival
%% 
%