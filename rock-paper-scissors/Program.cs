using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace rock_paper_scissors
{
	class Program
	{
		private enum Moves
		{
			Rock = 1,
			Paper = 2,
			Scissors = 3,
			Void = 4,
			Quit = 5
		}
		private static int playerWins = 0;
		private static int gameWins = 0;
		private static Random rnd;
		private static bool cheat = false;
		private static bool randomize = false;
		private static bool reportChunks = false;
		private static int games = 0;
		private static int maxGames = 25;
		private static Moves playersLastMove;
		private static bool? lastResult = null;
		private static bool usingStrategy = false;

		static void Main(string[] args)
		{
			Stopwatch stopWatch = new Stopwatch();
			stopWatch.Start();
			try
			{
				rnd = new Random();
				if (args.Length > 0)
				{
					if (args[0] == "-c")
					{
						cheat = true;
					}

					if (args[0] == "-r")
					{
						bool isValid = false;
						randomize = true;

						if (args.Length > 1)
						{
							isValid = Int32.TryParse(args[1], out maxGames);
						}

						if (!isValid)
						{
							maxGames = 1000000;
						}

						if (maxGames >= 100000000)
						{
							reportChunks = true;
						}
					}
				}

				if (!randomize)
				{
					Console.WriteLine($"We are going to play {maxGames} games.");
				}

				var keepGoing = true;
				while (games <= maxGames && keepGoing)
				{
					keepGoing = Play();
				}
				if (randomize)
				{
					Console.WriteLine($"me {gameWins} wins, you {playerWins} wins ({games - gameWins - playerWins})");
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}

			stopWatch.Stop();
			TimeSpan ts = stopWatch.Elapsed;

			string elapsedTime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}",
				ts.Hours, ts.Minutes, ts.Seconds,
				ts.Milliseconds / 10);
			Console.WriteLine("RunTime " + elapsedTime);
		}

		private static bool Play()
		{
			Moves gameMove = GetMove(true);
			var cheating = "";
			if (cheat)
			{
				cheating = $" {gameMove.ToString()}";
			}
			if (!randomize)
			{
				SendOutput($"R ock  P aper  S cissors (I have chosen{cheating})               me {gameWins} wins, you {playerWins} wins");
			}
			Moves playerMove = GetPlayerMove();
			GetWinner(playerMove, gameMove);


			if (playerMove != Moves.Quit)
			{
				if (reportChunks)
				{
					if (games % (maxGames / 10) == 0 && games > 0)
					{
						Console.WriteLine(games);
					}
				}
				if (playerMove != Moves.Void) //ignore void games
				{
					games++;
				}
			}
			else
			{
				return false;
			}

			return true;
		}

		private static Moves GetMove(bool isGame)
		{
			//fall back to just random, but use a bit of trickery that works on humans...

			Moves fallback = (Moves)rnd.Next(1, 4);
			usingStrategy = (fallback == Moves.Rock) ? true : false;  //1/3 of the time we'll use the strategy and mostly we won't

			if (isGame && usingStrategy && !randomize)
			{
				if (lastResult.HasValue && lastResult.Value)
				{
					fallback = playersLastMove;
				}
				else if(lastResult.HasValue && !lastResult.Value)
				{
					switch(playersLastMove)
					{
						case Moves.Rock:
							{ fallback = Moves.Paper; break; }
						case Moves.Paper:
							{ fallback = Moves.Scissors; break; }
						case Moves.Scissors:
							{ fallback = Moves.Rock; break; }
					}
				}
			}

			return fallback;
		}

		private static Moves GetPlayerMove()
		{
			if (randomize)
			{
				return GetMove(false);
			}

			var input = Console.ReadKey();
			SendOutput("");

			if (input.Key == ConsoleKey.Q)
			{
				return Moves.Quit;
			}

			return EvalPlayerMove(input.Key);

		}

		private static void SendOutput(string message)
		{
			if (!randomize)
			{
				Console.WriteLine(message);
			}
		}

		private static Moves EvalPlayerMove(ConsoleKey input)
		{
			Moves result;

			switch (input)
			{
				case ConsoleKey.R:
					{
						result = Moves.Rock;
						break;
					}
				case ConsoleKey.P:
					{
						result = Moves.Paper;
						break;
					}
				case ConsoleKey.S:
					{
						result = Moves.Scissors;
						break;
					}
				default:
					{
						SendOutput("Unexpected input. This game is void.");
						result = Moves.Void;
						break;
					}
			}

			return result;
		}

		private static void GetWinner(Moves player, Moves game)
		{
			bool? outcome = null;
			string strategy = (usingStrategy) ? " with strategy" : "";

			if (player == Moves.Rock)
			{
				playersLastMove = Moves.Rock;

				if (game == Moves.Paper)
				{
					SendOutput($"Paper covers rock, I win!{strategy}");
					outcome = true;
				}
				else if (game == Moves.Scissors)
				{
					SendOutput($"Rock smashes scissors, you win!{strategy}");
					outcome = false;
				}
				else
				{
					SendOutput($"We tied!{strategy}");
				}
			}
			if (player == Moves.Paper)
			{
				playersLastMove = Moves.Paper;

				if (game == Moves.Scissors)
				{
					SendOutput($"Scissors cut paper, I win!{strategy}");
					playersLastMove = Moves.Rock;
					outcome = true;
				}
				else if (game == Moves.Rock)
				{
					SendOutput($"Paper covers rock, you win!{strategy}");
					outcome = false;
				}
				else
				{
					SendOutput($"We tied!{strategy}");
				}
			}
			if (player == Moves.Scissors)
			{
				playersLastMove = Moves.Scissors;

				if (game == Moves.Rock)
				{
					SendOutput($"Rock smashes scissors, I win!{strategy}");
					playersLastMove = Moves.Rock;
					outcome = true;
				}
				else if (game == Moves.Paper)
				{
					SendOutput($"Scissors cut paper, you win!{strategy}");
					outcome = false;
				}
				else
				{
					SendOutput($"We tied!{strategy}");
				}
			}

			lastResult = outcome;

			if (outcome.HasValue && outcome.Value)
			{
				gameWins++;
			}
			else if (outcome.HasValue && !outcome.Value)
			{
				playerWins++;
			}
		}
	}
}
