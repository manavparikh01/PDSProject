import React, { useEffect, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import Chart from 'react-apexcharts';

const DailyEnergyChart = () => {
  const [energyData, setEnergyData] = useState([]);
  const { locationID } = useParams();

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(`http://127.0.0.1:5000/eventdata/daily/${locationID}`);
        const data = await response.json();
        setEnergyData(data.eventdata);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, []);

  const getFormattedDate = (dateString) => {
    const date = new Date(dateString);
    return `${date.getDate()}/${date.getMonth() + 1}`;
  };

  const generateDailyEnergyData = () => {
    const dailyEnergyData = energyData.map((entry) => ({
      Date: getFormattedDate(entry.Date),
      DailyEnergyUsage: entry.DailyEnergyUsage || '0.00',
      LocationID: entry.LocationID,
    }));

    return dailyEnergyData;
  };

  const chartData = {
    labels: generateDailyEnergyData().map((entry) => entry.Date),
    series: [
      {
        name: 'Daily Energy Usage',
        data: generateDailyEnergyData().map((entry) => parseFloat(entry.DailyEnergyUsage)),
      },
    ],
  };

  const chartOptions = {
    chart: {
      type: 'bar',
    },
    xaxis: {
      categories: chartData.labels,
      title: {
        text: 'Date',
      },
    },
    yaxis: {
      title: {
        text: 'Daily Energy Usage',
      },
    },
  };

  return (
    <div>
      <h1>Daily Energy Usage Chart</h1>
      <Chart options={chartOptions} series={chartData.series} type="bar" height={350} />
      <Link to={`/location/${locationID}`}>
      <button>Go Back</button>
      </Link>
    </div>
  );
};

export default DailyEnergyChart;
