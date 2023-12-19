import React, { useEffect, useState } from 'react';
import { Link, useParams, useNavigate } from 'react-router-dom';
import Chart from 'react-apexcharts';

const EnergyGraph = () => {
  const [energyData, setEnergyData] = useState(null);
  const { locationID, deviceID } = useParams();
  const history = useNavigate();

  useEffect(() => {
    const fetchData = async (deviceID) => {
      try {
        const response = await fetch(`http://127.0.0.1:5000/eventdata/${deviceID}`);
        const data = await response.json();
        setEnergyData(data.eventdata);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData(deviceID);
  }, [deviceID]);

  const handleDeleteDevice = async () => {
    try {
      const response = await fetch(`http://127.0.0.1:5000/delete_device/${deviceID}`, {
        method: 'DELETE',
      });

      if (response.ok) {
        console.log('Device deleted successfully!');
        history(`/location/${locationID}`);
      } else {
        console.error('Failed to delete device.');
      }
    } catch (error) {
      console.error('Error deleting device:', error);
    }
  };

  if (!energyData) {
    return <div>Loading...</div>;
  }

  // Group data by date
  const groupedData = energyData.reduce((acc, event) => {
    const date = new Date(event.Timestamp).toLocaleDateString();
    if (!acc[date]) {
      acc[date] = [];
    }
    acc[date].push(event);
    return acc;
  }, {});

  // Create separate series for each date
  const chartSeries = Object.keys(groupedData).map((date) => ({
    name: date,
    data: groupedData[date]
      .filter((event) => event.EventType === 'energy use')
      .map((event) => parseFloat(event.Value)),
  }));

  const chartOptions = {
    chart: {
      id: 'energy-chart',
      toolbar: {
        show: false,
      },
    },
    xaxis: {
      categories: energyData
        .filter((event) => event.EventType === 'energy use')
        .map((event) => new Date(event.Timestamp).toLocaleTimeString()),
    },
    yaxis: {
      title: {
        text: 'Energy Usage',
      },
    },
  };

  const uniqueMonths = [...new Set(energyData.map((event) => new Date(event.Timestamp).toLocaleDateString()))];


  return (
    <div>
      <h1>Energy Usage Graph</h1>
      <p>Data for the following days:</p>
      <ul>
        {uniqueMonths.map((month) => (
          <li key={month}>{month}</li>
        ))}
      </ul>
      <Chart options={chartOptions} series={chartSeries} type="line" height={350} />
      <Link to={`/location/${locationID}`}>
      <button>Go Back</button>
      </Link>
      <button onClick={handleDeleteDevice}>Delete Device</button>
    </div>
  );
};

export default EnergyGraph;

  