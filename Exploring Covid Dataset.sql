SELECT @@SERVERNAME

Select location,date from PortfolioProject1..CovidDeaths$

Select * from PortfolioProject1..CovidVaccinations$
order by date

Select location, date, population, total_cases, new_cases, total_deaths, (total_deaths/total_cases)*100 as Death_percentage
from PortfolioProject1..CovidDeaths$
where location= 'India'


Select location, date, population, total_cases, new_cases, total_deaths, (total_cases/population)*100 as infected_percentage
from PortfolioProject1..CovidDeaths$
order by 1,2

-- COUNTRIES WITH HIGH INFECTION RATE COMPARED TO POPULATION


Select location, population,
max(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as HighestInfected_percentage
from PortfolioProject1..CovidDeaths$
Group by location, population
ORDER BY 1,2

--Countries with highest death per population
select location, max(total_deaths) as total_death_count, max((total_deaths/population)*100) as death_percentage
from PortfolioProject1..CovidDeaths$
where continent is not null
group by location
order by death_percentage desc

-- showing the continents with highest death count per population
select continent, max(total_deaths) as total_death_count
from PortfolioProject1..CovidDeaths$
where continent is not null 
group by continent
order by total_death_count desc

-- New cases date wise
select date, sum(new_cases) as total_new_cases, sum(cast(new_deaths as int)) as total_new_deaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as death_percentage
from PortfolioProject1..CovidDeaths$
where new_cases != 0
group by date
order by date

-- Total death_percentage
select  sum(new_cases) as total_new_cases, sum(cast(new_deaths as int)) as total_new_deaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as death_percentage
from PortfolioProject1..CovidDeaths$
where new_cases != 0 and continent is not null



-- JOIN

Select cv.continent, cv.location, cv.date, cv.new_vaccinations, cv.population, 
sum(convert(int, cv.new_vaccinations)) over (partition by cv.location )
from PortfolioProject1..CovidDeaths$ as cd join
PortfolioProject1..CovidVaccinations$ as cv on cd.location = cv.location and cd.date= cv.date
where cv.continent is not null and cv.new_vaccinations is not null
order by  cv.location, cv.date