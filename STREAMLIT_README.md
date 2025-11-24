# Trading Intelligence System - Streamlit Application

A comprehensive multi-dashboard trading intelligence system built with Streamlit, implementing a multi-signal algorithmic trading framework with Interactive Brokers integration.

## Overview

The Trading Intelligence System is a sophisticated analytical platform designed to help traders make data-driven decisions by combining signals from four distinct analytical layers:

1. **Macro Analysis (F1):** Macroeconomic regime classification based on interest rates, yield curves, inflation, and volatility
2. **Fundamental Analysis (F2):** Company-level metrics and factor scoring (Value, Quality, Growth)
3. **Sentiment Analysis (F3):** NLP-based sentiment analysis of news and market data
4. **Market Microstructure (F4):** Technical indicators and pattern recognition for short-term signals

These signals are combined through an AI Signal Combiner (F5) and optimized using the Kelly Criterion (F6) for position sizing.

## Project Structure

```
streamlit_app/
├── app.py                          # Main Streamlit application
├── config.py                       # Configuration management
├── core/
│   ├── ib_connection.py           # Interactive Brokers API wrapper
│   └── state_manager.py           # Cross-dashboard state management
├── models/
│   ├── macro_classifier.py        # Macro regime classification
│   ├── sentiment_analyzer.py      # NLP sentiment analysis
│   ├── signal_combiner.py         # Signal combination & Kelly Criterion
│   └── technical_analyzer.py      # Technical indicators & signals
├── data/
│   └── (data processing modules - to be implemented)
├── dashboards/
│   └── (individual dashboard modules - to be implemented)
└── utils/
    └── logger.py                  # Logging utilities
```

## Installation

### Prerequisites

- Python 3.8+
- Interactive Brokers TWS or IB Gateway running locally (for live data)
- pip package manager

### Setup

1. **Create a virtual environment:**
   ```bash
   cd /home/ubuntu/trading_intelligence_system
   python3 -m venv venv
   source venv/bin/activate
   ```

2. **Install dependencies:**
   ```bash
   pip install streamlit ibapi pandas numpy scikit-learn nltk yfinance python-dotenv requests
   ```

3. **Configure environment variables:**
   - Copy `.env.example` to `.env`
   - Update IB connection settings (host, port, account ID)
   - Adjust model and dashboard parameters as needed

## Running the Application

### Start the Streamlit App

```bash
cd /home/ubuntu/trading_intelligence_system
source venv/bin/activate
streamlit run streamlit_app/app.py
```

The application will be available at `http://localhost:8501`

### Connect to Interactive Brokers

1. Ensure TWS or IB Gateway is running on your machine
2. In the sidebar, click "🔗 Connect" to establish connection
3. The connection status will display in the top-right corner

## Dashboards

### 📊 Overview Dashboard
- System status and key metrics
- Macro regime classification
- Sentiment regime classification
- Combined trading signal
- Recommended position size

### 🌍 Macro Analysis Dashboard
- Interest rates, yield curve slope, inflation trends
- Volatility index (VIX)
- Liquidity indicators
- Macro regime classification with confidence
- Historical macro indicators chart

### 💼 Corporate & Fundamental Dashboard
- Fundamental factor scores (Value, Quality, Growth)
- Company metrics (market cap, P/E ratio, EPS)
- Analyst ratings and revisions
- Factor scores comparison chart

### 📰 News & NLP Sentiment Dashboard
- Overall market sentiment score
- News and social media sentiment
- Sentiment regime classification
- Entity-specific sentiment scores
- Sentiment trends visualization

### 📊 Pattern Recognition & Market Microstructure Dashboard
- Technical indicators (RSI, moving averages, volatility)
- Trading mode detection (Momentum, Mean Reversion, Breakout)
- Micro-signals (momentum, mean reversion, breakout)
- Volume and volatility analysis

### 🎯 Trading Signal & Position Sizing Dashboard
- Combined trading signal (-1 to 1 scale)
- Signal confidence level
- Recommended position size (Kelly Criterion)
- Win probability and payoff ratio
- Signal interpretation

## Configuration

Edit `streamlit_app/config.py` or environment variables to customize:

### Interactive Brokers
- `IB_HOST`: Broker host (default: 127.0.0.1)
- `IB_PORT`: Broker port (7497 for paper, 7496 for live)
- `IB_CLIENT_ID`: Client ID for connection
- `IB_PAPER_TRADING`: Use paper trading (true/false)

### Models
- `REGIME_MODEL`: Macro regime model type (rule_based, hmm, lstm)
- `SENTIMENT_MODEL`: Sentiment model (vader, bert, transformer)
- `SIGNAL_COMBINER`: Signal combination method (conditional, gbm, dnn)
- `KELLY_FRACTION`: Fractional Kelly for position sizing (0.0-1.0)
- `MIN_CONFIDENCE`: Minimum confidence threshold for signals

### Dashboard
- `THEME`: Color theme (dark/light)
- `DASHBOARD_REFRESH`: Refresh interval in seconds

## Core Modules

### IBConnection (core/ib_connection.py)
Manages connection to Interactive Brokers and handles data requests:
- Real-time market data streaming
- Historical data fetching
- Connection lifecycle management
- Error handling and reconnection logic

### StateManager (core/state_manager.py)
Centralized state management for cross-dashboard communication:
- Macro state (regime, indicators, confidence)
- Fundamental state (company metrics, factor scores)
- Sentiment state (regime, scores, entity sentiments)
- Microstructure state (technical signals, trading mode)
- Signal state (combined signal, position size)

### MacroRegimeClassifier (models/macro_classifier.py)
Rule-based macro regime classification:
- Normalizes indicators (interest rates, yield curve, inflation, VIX)
- Classifies into regimes: Risk-On, Risk-Off, Growth, Inflationary, Stress
- Provides confidence scores

### SentimentAnalyzer (models/sentiment_analyzer.py)
NLP-based sentiment analysis:
- VADER sentiment analysis (with NLTK fallback)
- Entity extraction from news
- Sentiment regime classification
- Entity-specific sentiment tracking

### TechnicalAnalyzer (models/technical_analyzer.py)
Technical indicator calculations:
- RSI (Relative Strength Index)
- Moving averages (SMA)
- ATR (Average True Range)
- Volatility calculation
- Breakout and mean reversion detection
- Trading mode selection

### SignalCombiner (models/signal_combiner.py)
Combines signals and applies Kelly Criterion:
- Weighted combination of F1-F4 signals
- Regime-based weight adjustment
- Confidence calculation
- Kelly Criterion position sizing
- Fractional Kelly for risk control

## MVP Features (Phase 1)

✅ **Implemented:**
- Modular architecture with clear separation of concerns
- Interactive Brokers API integration (connection, data fetching)
- Rule-based macro regime classifier
- VADER sentiment analysis with entity extraction
- Technical indicator calculations
- Conditional signal combiner with regime-switching
- Fixed fractional Kelly position sizing
- Multi-dashboard Streamlit interface
- Cross-dashboard state management
- Comprehensive logging and error handling

⏳ **Future Phases:**
- Advanced ML models (HMM for macro, Transformer for sentiment, GBM/DNN for signals)
- Full Kelly Criterion with probability calibration
- Real-time execution gateway
- Backtesting engine
- Live trading capabilities
- Advanced monitoring and alerting

## Testing

Run unit tests for core modules:

```bash
# Test macro classifier
python -m pytest streamlit_app/models/test_macro_classifier.py -v

# Test signal combiner
python -m pytest streamlit_app/models/test_signal_combiner.py -v

# Test IB connection
python -m pytest streamlit_app/core/test_ib_connection.py -v
```

## Troubleshooting

### Connection Issues
- Ensure TWS or IB Gateway is running
- Check host and port settings in config
- Verify firewall allows connections
- Check IB logs for authentication errors

### Data Not Updating
- Verify IB connection status in sidebar
- Check that tickers are correctly formatted
- Review logs for error messages
- Ensure sufficient historical data is available

### Performance Issues
- Reduce dashboard refresh interval
- Limit number of tickers being monitored
- Check system resources (CPU, memory)
- Consider running on a dedicated machine

## Roadmap

### Phase 1: Foundation & MVP (Current)
- ✅ Data pipelines and infrastructure
- ✅ Rule-based regime switching
- ✅ Fixed fractional sizing
- ✅ MVP dashboards

### Phase 2: AI Enhancement (Q1 2026)
- HMM Macro Regime Model
- Transformer-based Sentiment Model
- GBM/DNN Signal Combiner with probability output
- Kelly Criterion inputs (win probability, payoff ratio)

### Phase 3: Production & Automation (Q2 2026)
- Low-latency execution gateway
- Real-time production environment
- Live trading capabilities
- Robust monitoring and alerting

## References

- Interactive Brokers API: https://www.interactivebrokers.com/en/software/tws/usersguidebook/apiguide/api.htm
- Streamlit Documentation: https://docs.streamlit.io/
- Kelly Criterion: https://en.wikipedia.org/wiki/Kelly_criterion
- VADER Sentiment Analysis: https://github.com/cjhutto/vaderSentiment

## License

Proprietary - Trading Intelligence System

## Support

For issues or questions, refer to the logging output and check the troubleshooting section above.
