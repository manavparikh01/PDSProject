import React, { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useCustomerContext } from '../customerContext';
import Chart from 'react-apexcharts';

const EnergyCostChart = () => {
    const { customerID } = useCustomerContext();
  const [energyData, setEnergyData] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(`http://127.0.0.1:5000/eventdata/location_wise/${customerID}`);
        const data = await response.json();
        setEnergyData(data.eventdata);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, []);

  const chartData = {
    labels: energyData.map((entry) => entry.Address),
    series: [
      {
        name: 'Total Energy Cost',
        data: energyData.map((entry) => parseFloat(entry.TotalEnergyCost)),
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
        text: 'Location',
      },
    },
    yaxis: {
      title: {
        text: 'Total Energy Cost',
      },
    },
  };

  return (
    <div>
      <h1>Total Energy Cost Per Location (August 2022)</h1>
      <Chart options={chartOptions} series={chartData.series} type="bar" height={350} />
      <Link to={`/locations`}>
      <button>Go Back</button>
      </Link>
    </div>
  );
};

export default EnergyCostChart;
