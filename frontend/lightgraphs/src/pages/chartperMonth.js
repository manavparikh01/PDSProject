import React, { useEffect, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import Chart from 'react-apexcharts';

const EnergyBarChart = () => {
  const [energyData, setEnergyData] = useState([]);
  const { locationID } = useParams();

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(`http://127.0.0.1:5000/eventdata/monthly/${locationID}`);
        const data = await response.json();
        setEnergyData(data.eventdata);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, []);

  const chartOptions = {
    chart: {
      type: 'bar',
    },
    xaxis: {
      categories: energyData.map((entry) => `${entry.Month}/${entry.Year}`),
      title: {
        text: 'Month/Year',
      },
    },
    yaxis: {
      title: {
        text: 'Total Energy Usage',
      },
    },
  };

  const chartSeries = [
    {
      name: 'Total Energy Usage',
      data: energyData.map((entry) => parseFloat(entry.TotalEnergyUsage)),
    },
  ];

  return (
    <div>
      <h1>Total Energy Usage Per Month</h1>
      <Chart options={chartOptions} series={chartSeries} type="bar" height={350} />
      <Link to={`/location/${locationID}`}>
      <button>Go Back</button>
      </Link>
    </div>
  );
};

export default EnergyBarChart;
